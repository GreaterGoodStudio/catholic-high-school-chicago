<template>
  <div @submit.prevent="search" @change="search" :class="{ 'show-list': showList, 'invalid-zipcode': !validZIPCode, 'full-form': showFullForm }">
    <slot name="form"></slot>

    <div id="school-list">
      <ul class="unstyled">
        <li class="school" v-for="school in schoolList">
          <h5>{{ school.name }}</h5>
          <p class="address">{{ school.address }}</p>
          <a :href="school.path" class="btn btn-block">{{ more_info }}</a>
        </li>
      </ul>
    </div>

    <a href="#" class="btn btn-block btn-toggle" @click.prevent="toggleList">
      <slot name="toggle"></slot>
    </a>
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    mounted() {
      this.init()
      this.updateSchools(this.schools)
    },

    props: ['schools', 'query', 'zipcode', 'locale', 'more_info'],

    computed: {
      ...mapState({
        schoolList: state => state.schools,
        loading: state => state.loading
      })
    },

    data () {
      return {
        showFullForm: false,
        showList: false,
        validZIPCode: true,
      }
    },

    methods: {
      init() {
        let zipcode = this.zipcode || ""

        this.$store.commit('initStore', { query: this.query, zipcode: zipcode })
        this.showFullForm = this.zipcode
      },

      search() {
        let params = {
          zipcode: this.$store.state.zipcode,
          q: this.$store.state.query
        }

        this.validZIPCode = /\d{5}/.test(params.zipcode)
        this.showFullForm = this.validZIPCode

        if (!this.validZIPCode) return

        this.$store.commit('updateLoading', true)

        this.$http.post(`/${this.locale}/search`, params).then(response => {
          let schools = JSON.parse(response.body.schools)
          let bookmark = response.body.bookmark

          this.updateSchools(schools)
          this.updateBookmark(bookmark)

          this.$store.commit('updateLoading', false)
        }, error => {
          console.log(error)
        })
      },

      toggleList () {
        this.showList = !this.showList
      },

      updateBookmark(bookmark) {
        if (!history.pushState) return

        history.pushState({}, "", bookmark)
      },

      updateSchools(newSchools) {
        this.$store.commit('setSchools', newSchools)
      }
    }
  }
</script>