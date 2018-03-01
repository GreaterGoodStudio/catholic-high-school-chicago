/* eslint no-console: 0 */

import '../polyfills'
import Turbolinks from 'turbolinks'
import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import VueResource from 'vue-resource'
import VueCookie from 'vue-cookie'

import Modal from '../modal.vue'
import SchoolMap from '../school_map.vue'
import Search from '../search.vue'
import SearchHeader from '../search_header.vue'

Turbolinks.start()

Vue.use(TurbolinksAdapter)
Vue.use(Vuex)
Vue.use(VueResource)
Vue.use(VueCookie)

const store = new Vuex.Store({
  state: {
    zipcode: undefined,
    query: {},
    schools: [],
    loading: false,
    mobileMenu: false,
    mobileFilters: false
  },

  mutations: {
    initStore (state, obj) {
      Vue.set(state, 'query', obj.query)
      Vue.set(state, 'zipcode', obj.zipcode)
    },

    setSchools (state, schools) {
      Vue.set(state, 'schools', schools)
    },

    updateLoading (state, val) {
      state.loading = val
    },

    toggleFilters (state) {
      state.mobileFilters = !state.mobileFilters
    },

    toggleMenu (state) {
      state.mobileMenu = !state.mobileMenu
    }
  }
})

document.addEventListener('turbolinks:load', (e) => {
  Vue.http.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name=csrf-token]').getAttribute('content')

  store.state.mobileFilters = store.state.mobileMenu = false

  new Vue({
    el: ".wrap",
    components: { Modal, SchoolMap, Search, SearchHeader },
    store: store
  })
})
