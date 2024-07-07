import { LightningElement } from 'lwc';

export default class AttendanceCalendar extends LightningElement {
    presentDates = ['2024-01-01', '2024-01-05', '2024-01-10'];
    absentDates = ['2024-01-03', '2024-01-08', '2024-01-15'];


    selectedMonth;
    selectedYear;
    month = '';
    weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    months = [
        { label: 'January', value: '0' },
        { label: 'February', value: '1' },
        { label: 'March', value: '2' },
        { label: 'April', value: '3' },
        { label: 'May', value: '4' },
        { label: 'June', value: '5' },
        { label: 'July', value: '6' },
        { label: 'August', value: '7' },
        { label: 'September', value: '8' },
        { label: 'October', value: '9' },
        { label: 'November', value: '10' },
        { label: 'December', value: '11' },
    ];

    connectedCallback() {
        const currentDate = new Date();
        this.selectedMonth = String(currentDate.getMonth());
        this.selectedYear = String(currentDate.getFullYear());
        this.generateCalendar();
    }

    handleMonthChange(event) {
        this.selectedMonth = event.detail.value;
        this.generateCalendar();
    }

    handleYearChange(event) {
        this.selectedYear = event.detail.value;
        this.generateCalendar();
    }

    generateCalendar() {
        const currentMonth = parseInt(this.selectedMonth);
        const currentYear = parseInt(this.selectedYear);
        const firstDayOfMonth = new Date(currentYear, currentMonth, 1).getDay();
        const lastDayOfMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

        this.month = new Date(currentYear, currentMonth, 1).toLocaleString('default', { month: 'long' });

        let calendar = [];
        let week = [];

        for (let i = 1; i <= lastDayOfMonth; i++) {
            const date = new Date(currentYear, currentMonth, i+1);
            const dayOfWeek = date.getDay();
            let classes = '';
           
            if (this.presentDates && this.presentDates.includes(date.toISOString().split('T')[0])) {
                classes = 'present';
            } else if (this.absentDates && this.absentDates.includes(date.toISOString().split('T')[0])) {
                classes = 'absent';
            } else {
                classes = 'blank';
            }
            i = i < 10 ? '0'+ i : i;
            week.push({ value: i, classes: classes });

            if (dayOfWeek === 0) {
                calendar.push(week);
                week = [];
            }
        }

        if (week.length > 0) {
            calendar.push(week);
        }

        this.calendar = calendar;
    }

    get years() {
        const years = [];
        const currentYear = new Date().getFullYear();
        for (let year = currentYear - 5; year <= currentYear + 5; year++) {
            years.push({ label: String(year), value: String(year) });
        }
        return years;
    }
}