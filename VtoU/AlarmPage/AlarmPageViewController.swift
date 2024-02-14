//
//  AlarmPageViewController.swift
//  VtoU
//
//  Created by JungGue LEE on 2024/01/29.
//

import Foundation
import UIKit
import FSCalendar

class AlarmPageViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    //var calendar: FSCalendar!
    @IBOutlet weak var calendar: FSCalendar!
    var viewModel: CalendarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CalendarViewModel()
        setupCalendar()
    }
    
    func setupCalendar() {
        calendar.locale = Locale(identifier:"ko")
        calendar.scope = .week

        calendar.setCurrentPage(Date(), animated: false)
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 날짜를 선택했을 때 호출되는 메서드
    }
        
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // 특정 날짜에 이벤트(약 복용)의 개수를 반환하는 메서드
        return viewModel.numberOfEvents(for: date) ?? 0
    }

         
    // 색상을 업데이트하는 메서드
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if viewModel.didTakeAllMedicines(on: date) {
            return [UIColor.green] // 모든 약을 복용했으면 초록색
        } else {
            return [UIColor.red] // 복용하지 않은 약이 있으면 빨간색
        }
    }
    
}

class CalendarViewModel {
    // 여기에 캘린더 데이터와 관련된 변수와 메서드를 정의합니다.
    
    func numberOfEvents(for date: Date) -> Int {
        // 특정 날짜에 대한 이벤트 개수를 계산하여 반환합니다.
        return 0 // 예시 값
    }
    
    func didTakeAllMedicines(on date: Date) -> Bool {
        // 해당 날짜에 모든 약을 복용했는지 확인합니다.
        return true // 예시 값
    }
}
