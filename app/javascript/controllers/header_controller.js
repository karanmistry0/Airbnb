import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'
export default class extends Controller{

    static targets = ["openUserMenu","dropdown"]

    connect(){

        this.openUserMenuTarget.addEventListener("click",(e)=>{
            openDropdown(this.dropdownTarget)
        })
    }
}

function openDropdown(element){
    toggle(element)
}
