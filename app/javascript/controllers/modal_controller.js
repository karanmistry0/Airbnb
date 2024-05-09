import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'
export default class extends Controller {

    toggleModal(){
        const id = this.element.id
        toggle(document.getElementById(`${id}`));
    }
}