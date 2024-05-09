import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'
export default class extends Controller {
  toggleSearchShow(){
    document.getElementById("search").click();
  }
}