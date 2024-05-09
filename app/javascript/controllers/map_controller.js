import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["property","latitude","longitude"]


    connect() {


        let map;
        let markers = [];
        const properties = this.propertyTargets;
        const setlatitude = this.latitudeTargets;
        const setlongitude = this.longitudeTargets;
        async function initMap() {
            let initialposition;
            // The location of Uluru
            if (properties.length != 0){
                initialposition = {
                    lat: parseFloat(properties[0].dataset.latitude),
                    lng: parseFloat(properties[0].dataset.longitude) };
            }
            else {
                initialposition = {
                    lat: 0,
                    lng: 0 };
            }
            // Request needed libraries.
            //@ts-ignore
            const { Map } = await google.maps.importLibrary("maps");
            const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

            // The map, centered at Uluru
            map = new Map(document.getElementById("map"), {
                zoom: 4,
                center: initialposition,
                mapId: "DEMO_MAP_ID",
            });

            if(properties.length != 0 ){
                properties.forEach(element => {

                    const location = { lat: parseFloat(element.dataset.latitude), lng: parseFloat(element.dataset.longitude) };


                    const priceTag = document.createElement("div");

                    priceTag.className = "price-tag";
                    priceTag.textContent = element.dataset.price;


                    const marker = new AdvancedMarkerElement({
                        map: map,
                        position: location,
                        content: priceTag,
                    });
                    markers.push(marker);
                })
            }

            else{

                map.addListener("click", (mapsMouseEvent) => {

                    if(setlatitude && setlongitude){
                        setlatitude.value = mapsMouseEvent.latLng.toJSON().lat;
                        setlongitude.value = mapsMouseEvent.latLng.toJSON().lng;
                    }
                    // Close the current InfoWindow.
                    const location = document.createElement("div");

                    location.className = "price-tag";
                    location.textContent = element.dataset.price;

                    for(let i=0;i<markers.length;i++){
                        markers[i].setMap(null);
                    }

                    const marker = new AdvancedMarkerElement({
                        map: map,
                        position:  mapsMouseEvent.latLng.toJSON(),
                        content: location,
                    });
                    markers.push(marker);
                });
            }
        }

        initMap();
    }
}
