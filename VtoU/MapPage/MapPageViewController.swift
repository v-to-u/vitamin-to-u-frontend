//
//  MapPageViewController.swift
//  VtoU
//
//  Created by JungGue LEE on 2024/01/30.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces


class MapPageViewController: UIViewController, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate, UISearchBarDelegate, GMSMapViewDelegate {
    
    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    var selectedPlace: GMSPlace?
    let searchBar = UISearchBar()
    let topSafeAreaView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 현재 위치 가져오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
                
        // 위, 경도 가져오기
        let coor = locationManager.location?.coordinate
                
        // 기본 위치 설정
        let defaultLatitude: Double = 37.566508
        let defaultLongitude: Double = 126.977945
        let camera = GMSCameraPosition.camera(withLatitude: defaultLatitude, longitude: defaultLongitude, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coor?.latitude ?? 37.566508, longitude: coor?.longitude ?? 126.977945)
        marker.title = "Me"
        marker.snippet = "My Position"
        marker.map = mapView
        
        setupSearchBar()
        
        mapView.delegate = self
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        didTapDirections()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16.0)
        locationManager.stopUpdatingLocation()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for places"
        view.addSubview(searchBar)
                
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 56)
        ])
        searchBar.searchTextField.layer.cornerRadius = 20.0
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 20.0
        searchBar.layer.masksToBounds = true
    }
    
    // 검색 바를 탭했을 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedPlace = place
        dismiss(animated: true, completion: nil)

        // 선택된 장소로 지도 이동
        mapView.clear() // 이전 마커 제거
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
        mapView.animate(to: camera)

        // 마커 생성
        let marker = GMSMarker(position: place.coordinate)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = mapView
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // 오류 처리
        print("Error: ", error.localizedDescription)
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 8

        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: 184, height: 20))
        titleLabel.text = marker.title
        infoView.addSubview(titleLabel)

        let snippetLabel = UILabel(frame: CGRect(x: 8, y: 28, width: 184, height: 20))
        snippetLabel.text = marker.snippet
        snippetLabel.font = snippetLabel.font.withSize(12)
        infoView.addSubview(snippetLabel)

        let button = UIButton(frame: CGRect(x: 50, y: 48, width: 100, height: 20))
        button.setTitle("길 찾기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapDirections), for: .touchUpInside)
        infoView.addSubview(button)

        return infoView
    }
    
}
extension MapPageViewController {
    @objc func didTapDirections() {
        guard let origin = locationManager.location?.coordinate,
                  let destination = selectedPlace?.coordinate else {
                print("출발지나 목적지 정보가 없습니다.")
                return
            }
            let originString = "\(origin.latitude),\(origin.longitude)"
            let destinationString = "\(destination.latitude),\(destination.longitude)"
            fetchDirections(from: originString, to: destinationString)
    }

    func fetchDirections(from origin: String, to destination: String) {
        let directionsURLString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking&key=API-KEY" //API-KEY!!
        
        guard let directionsURL = URL(string: directionsURLString) else { return }
        
        URLSession.shared.dataTask(with: directionsURL) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                if let jsonResult = jsonResult, let routes = jsonResult["routes"] as? [Any], !routes.isEmpty, let route = routes[0] as? NSDictionary, let overviewPolyline = route["overview_polyline"] as? NSDictionary, let points = overviewPolyline["points"] as? String {
                    DispatchQueue.main.async {
                        self.showRoute(polyline: points)
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    func showRoute(polyline: String) {
        guard let path = GMSPath(fromEncodedPath: polyline) else { return }
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
        let bounds = GMSCoordinateBounds(path: path)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50))
    }
    
}
