import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ['icon','text']
    updateWhislistStatus(e){
        e.preventDefault()
        if(this.element.dataset.userLoggedIn === "false"){
            document.querySelector(".js-login").click();
        }
        else{
            if (this.element.dataset.status === 'false'){
                const propertyId = this.element.dataset.propertyId;
                const userId = this.element.dataset.userId;
                console.log('property_id',propertyId);
                console.log('user_id',userId);
                this.addPropertyToWishlist(propertyId,userId)
            }
            else{
                const whistlistId = this.element.dataset.whistlistId;
                this.removePropertyFromWhislist(whistlistId)
            }
        }



    }
    addPropertyToWishlist(propertyId, userId){
        const params = {
            property_id: propertyId,
            user_id: userId,
        };

        const options = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(params),
        };

        fetch('/api/whislists', options)
            .then(response => {
                if (!response.ok) {
                    console.log(response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log(data);
                this.element.dataset.whistlistId = data.id;
                this.iconTarget.classList.remove("fill-none");
                this.iconTarget.classList.add("fill-primary");
                this.element.dataset.status = "true";
                if(this.textTarget){
                    this.textTarget.innerText = "Saved";
                }
            })
            .catch(e => {
                console.log(e);
            });
    }

    removePropertyFromWhislist(whislistId){
        fetch('/api/whislists/'+whislistId ,{method: 'DELETE'})
            .then(response => {
                this.element.dataset.whistlistId = '';
                this.iconTarget.classList.remove("fill-primary");
                this.iconTarget.classList.add("fill-none");
                this.element.dataset.status = "false";
                if(this.textTarget){
                    this.textTarget.innerText = "Save";
                }
            })
            .catch(e => {
                console.log(e);
            });
    }

}