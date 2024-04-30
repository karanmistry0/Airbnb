import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {

    SERVICE_FEE = 0.18;

    static targets = ["numberOfNights","baseFare","serviceFee","totalTaxes","checkin","checkout"]

    disabledDates = []
    connect() {

        this.formatBlockedDates();
        flatpickr(this.checkinTarget,{
            minDate: new Date().fp_incr(1),
            disable: this.disabledDates,
            onChange: (selectedDates, dateStr, instance) => {
                this.triggerCheckoutDatePicker(selectedDates);
            },
        });
        this.updateDetails();
    }

    triggerCheckoutDatePicker(selectedDates){
        flatpickr(this.checkoutTarget,{
            minDate: new Date(selectedDates).fp_incr(1),
            disable: this.disabledDates,
            onChange: (selectedDates, dateStr, instance) => {
                this.updateDetails();
            },
        });
        this.checkoutTarget.click();


    }

    formatBlockedDates(){
        const formatted_dates = JSON.parse(this.element.dataset.formattedDate)

        for (let i=0;i<formatted_dates.length;i++){
            let dates = formatted_dates[i]
            this.disabledDates.push(
                {
                    from:dates[0],
                    to:dates[1]
                }
            )
        }
    }

    updateDetails(){
        const nightsCount = this.numberOfNights();
        const baseFare = this.calculateBaseFare(nightsCount);
        const serviceFee = this.calculateServiceFee(baseFare);
        this.numberOfNightsTarget.textContent=nightsCount;
        this.baseFareTarget.textContent = baseFare;
        this.serviceFeeTarget.textContent = serviceFee ;
        this.totalTaxesTarget.textContent = this.calculateTotalTaxes(baseFare,serviceFee);
    }

    numberOfNights(){
        const checkinDate = new Date(this.checkinTarget.value);
        const checkoutDate = new Date(this.checkoutTarget.value);
        return (checkoutDate - checkinDate)/(1000*60*60*24);
    }

    calculateBaseFare(nightsCount){
        return parseFloat((nightsCount * this.element.dataset.perNightPrice).toFixed(2));
    }

    calculateServiceFee(baseFare){
        return parseFloat((baseFare * this.SERVICE_FEE).toFixed(2));
    }

    calculateTotalTaxes(baseFare,serviceFee){
        return parseFloat((baseFare + serviceFee).toFixed(2));
    }

    reserveProperty(e){

        const paramsDate = {
            checkin_date:this.checkinTarget.value,
            checkout_date:this.checkoutTarget.value
        }

        const paramsUrl = (new URLSearchParams(paramsDate)).toString()

        e.preventDefault();
        const baseUrl = e.target.dataset.bookingPropertyUrl;
        Turbo.visit(`${baseUrl}?${paramsUrl}`);
    }
}