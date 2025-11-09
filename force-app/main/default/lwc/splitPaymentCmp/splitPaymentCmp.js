import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class SplitPaymentCmp extends LightningElement {
    totalCharges = 100;
    remainingCharges = 100;
    isSplitEnabled = false;
    index = 0;
    @track paymentList = [
        this.createPayment(1, true),
        this.createPayment(2, false),
        this.createPayment(3, false)
    ];

    get formattedRemainingCharges() {
        return `$${this.remainingCharges.toFixed(2)}`;
    }

    get maskedCard() {
        const card = this.paymentList[this.index]?.cardDetails.cardNumber || '';
        return card.slice(-4);
    }

    createPayment(id, visible) {
        return {
            id,
            isVisible: visible,
            isCompleted: false,
            isDisabled: false,
            isPayEnable:true,
            isFirstPayment: !(id === 1),
            isDisabledConfirm: true,
            activeTab: 'card',
            paymentAmount: '',
            cardDetails: { cardNumber: '4242424242424242', expiry: '11/25', cvv: '123', name: 'Richard' }
        };
    }

    handleSplitToggle(event) {
        this.isSplitEnabled = event.target.checked;

        if (this.isSplitEnabled) {
            this.paymentList = [
                { ...this.paymentList[0], isVisible: true, isDisabled: false },
                { ...this.paymentList[1], isVisible: false, isDisabled: true },
                { ...this.paymentList[2], isVisible: false, isDisabled: false }
            ];

        }

        if (!this.isSplitEnabled) {
            // reset all but first
            this.paymentList = [
                { ...this.paymentList[0], isVisible: true, isCompleted: false },
                this.createPayment(2, false),
                this.createPayment(3, false)
            ];
            this.remainingCharges = this.totalCharges;
        }
    }

    handleInputChange(event) {
        const id = parseInt(event.target.dataset.id, 10);
        const { name, value } = event.target;

        this.paymentList = this.paymentList.map(payment => {
            if (payment.id === id) {
                if (name === 'paymentAmount') {
                    return { ...payment, paymentAmount: parseFloat(value) || 0 , isPayEnable: this.isSplitEnabled ? !(parseFloat(value) > 0) : !(parseFloat(value) > 0 && parseFloat(value) >= this.remainingCharges) };
                } else {
                    return {
                        ...payment,
                        cardDetails: { ...payment.cardDetails, [name]: value }
                    };
                }
            }
            return payment;
        });
    }

    handlePay(event) {
        // Logic to process payment and update remaining charges
        const id = parseInt(event.target.dataset.id, 10);
        const current = this.paymentList.find(p => p.id === id);
        this.remainingCharges = parseFloat(
            (this.remainingCharges - current.paymentAmount).toFixed(2)
        );
        this.paymentList = this.paymentList.map(payment => {
            if (payment.id === id) {
                return {
                    ...payment,
                    isFirstPayment: (!this.isSplitEnabled && this.remainingCharges === 0),
                    isDisabledConfirm: (this.remainingCharges > 0 && !this.isSplitEnabled)}
            };   
            return payment;
        });
        const toastEvent = new ShowToastEvent({
            title: "Payment Done",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
    
    handleConfirm(event) {
        const id = parseInt(event.target.dataset.id, 10);

        // Collapse current payment
        this.paymentList = this.paymentList.map(p =>
            p.id === id ? { ...p, isCompleted: true } : p
        );

        // CASE 1: Split is OFF → Stop here
        if (!this.isSplitEnabled) {
            return;
        }

        // CASE 2: Remaining becomes 0 → Collapse
        if (this.remainingCharges <= 0) {
            this.paymentList = this.paymentList.map((p, index) => ({
                ...p,
                isCompleted: true,
                isVisible: (index+1) <= id,  
                isDisabled: false
            }));
            return;
        }

        // CASE 3: Split ON + remaining > 0 → Enable next payment only
        const nextId = id + 1;

        this.paymentList = this.paymentList.map(p => {
            if (p.id === nextId) {
                return {
                    ...p,
                    isVisible: true,
                    isDisabled: false,
                    isCompleted: false
                };
            }

            // All further payments should be hidden and disabled
            if (p.id > nextId) {
                return {
                    ...p,
                    isVisible: false,
                    isDisabled: true,
                    isCompleted: false
                };
            }

            return p;
        });
    }


}