<template>
  <div id="map"></div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    mounted() {
      this.configureMapbox()
      this.createMap()
      this.addControls()
      this.addGeolocator()
    },

    props: {
      center: {
        type: Array,
        default: () => {
          return [-87.61, 41.87]
        }
      },
      interactive: Boolean,
      zoom: {
        type: Number,
        default: 11
      }
    },

    computed: {
      ...mapState({
        schools: state => state.schools
      })
    },

    data() {
      return {
        markers: []
      }
    },

    watch: {
      schools: function (schools, oldSchools) {
        this.removeMarkers()

        for (let school of schools) {
          let marker = this.addMarker(school.coordinates)
          this.addPopup(marker, school)
          this.markers.push(marker)
        }
      }
    },

    methods: {
      configureMapbox() {
        const accessToken = document.querySelector("meta[name=mapbox-access-token]").getAttribute("content")
        mapboxgl.accessToken = accessToken
      },

      createMap() {
        this.map = new mapboxgl.Map({
          attributionControl: false,
          center: this.center,
          container: this.$el,
          interactive: this.interactive,
          maxBounds: new mapboxgl.LngLatBounds(
            new mapboxgl.LngLat(-88.993548, 40.504335),
            new mapboxgl.LngLat(-86.505286, 43.400389)
          ),
          style: "mapbox://styles/bsfhswebsite/cjgo310uj005f2rqw6046lugh",
          zoom: this.zoom,
          minZoom: 9
        })

        // Mark the center, if it was passed in as prop
        if (this.$options.propsData.center) {
          this.addMarker(this.center)
        }
      },

      addControls() {
        if (!this.interactive) return

        this.map.addControl(new mapboxgl.NavigationControl())
      },

      addGeolocator() {
        if (!this.interactive) return

        const geolocate = new mapboxgl.GeolocateControl({
          fitBoundsOptions: {
            maxZoom: 12
          },
          positionOptions: {
            enableHighAccuracy: true
          },
          showUserLocation: false,
          trackUserLocation: true
        })

        geolocate.on("geolocate", (e) => {
          // Perform search?
        })

        this.map.addControl(geolocate)
      },

      addMarker(latlng) {
        return new mapboxgl.Marker()
                    .setLngLat(latlng)
                    .addTo(this.map)
      },

      addPopup(marker, school) {
        let popup = new mapboxgl.Popup()
        let html = `<a href="${school.path}">${school.name}</a>`

        popup.setHTML(html)
        marker.setPopup(popup)
      },

      removeMarkers() {
        while (this.markers.length) {
          let marker = this.markers.pop()
          marker.remove()
        }
      }
    }
  }
</script>