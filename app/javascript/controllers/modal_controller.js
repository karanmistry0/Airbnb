import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'
export default class extends Controller {
    connect() {
       console.log("Modal connected")
    }
    toggleModal(){
        const id = this.element.id
        console.log(id)
        toggle(document.getElementById(`${id}`));
    }
}