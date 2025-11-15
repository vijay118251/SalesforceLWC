import { LightningElement,track } from 'lwc';

export default class ReusablePayStationCmp extends LightningElement {
    showPaymentModal = false;
    isStationFetched = false;
    totalCharges = 100;
    remainingCharges = 100;
    countdownTimer = 3;
    countdownInterval;
    @track stationDetails = [
        this.createStations(1,'Available'),
        this.createStations(2,'Occupied'),
        this.createStations(3,'Available'),
        this.createStations(4,'Pending'),
        this.createStations(5,'Approved')
    ];

    get formattedRemainingCharges() {
        return `$${this.remainingCharges.toFixed(2)}`;
    }

    createStations(id , stationsStatus) {
        return {
            index: id,
            stationId : 'PayStation '+id,
            stationsStatus : stationsStatus,
            isPayEnable : stationsStatus === 'Available' ? false : true,
            location: 'Chennai',
            activeTab: 'card',
            selectedStationId: id,
            selectedStation: false
        };
    }


    handleFetchStation() {
        this.isStationFetched = true;
    }

    handleSelectedStation(event) {
        const stationId = event.target.dataset.id;
        this.stationDetails = this.stationDetails.map( station => {
            if(station.stationId === stationId) {
                return {
                    ...station,
                    selectedStation: true
                };
            } else {
                return {
                    ...station,
                    selectedStation: false
                };
            }
        });
    }

    handleInputChange(event) {
        const field = event.target.name;
        const value = event.target.value;
        this.stationDetails = this.stationDetails.map( station => {
            if(station.selectedStation) {
                return {
                    ...station,
                    [field] : value
                };
            } else {
                return station;
            }
        });
    }

    handleCloseModal() {
        this.isStationFetched = false;
    }

    handleClosePaymentModal(event) {
        this.showPaymentModal = event.detail.autoClose ? false : this.showPaymentModal;
    }

    handleConfirm(event) {
        const stationId = event.target.dataset.id;
        const selectedStation = this.stationDetails.find( station => station.stationId === stationId);
        const paymentAmount = parseFloat(selectedStation.paymentAmount) || 0;                   
        this.remainingCharges = this.remainingCharges - paymentAmount;
        this.stationDetails = this.stationDetails.map( station => {
            if(station.stationId === stationId) {
                return {
                    ...station,
                    selectedStation: false,
                    stationsStatus: 'Used',
                    isPayEnable: true,
                };
            } else {
                return station;
            }
        });
        this.showPaymentModal = true;
        this.startCountdown();
    }

    startCountdown() {
        this.countdownTimer = 3;
        if (this.countdownInterval) {
            clearInterval(this.countdownInterval);
        }
        this.countdownInterval = setInterval(() => {
            this.countdownTimer--;
        }, 1000);
    }
}