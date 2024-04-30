import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'
export default class extends Controller {
    connect() {
        console.log("reviews connected")
    }
    toggleReviewsShow(){
        document.getElementById("reviews").click();
    }
}