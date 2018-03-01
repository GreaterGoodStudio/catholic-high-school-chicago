<template>
  <div class="modal" @click="close" :class="{ hidden: hidden }">
    <div class="modal-wrap">
      <div class="modal-content">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['onclose'],

    mounted() {
      this.hidden = this.$cookie.get('greet')
    },

    data() {
      return {
        hidden: false
      }
    },

    methods: {
      close(e) {
        if (!e.target.getAttribute('data-close')) return

        e.preventDefault()

        this.hidden = true

        // If we passed in an onclose method name
        this.onclose && this[this.onclose]()
      },

      setCookie() {
        this.$cookie.set('greet', false, 10000)
      }
    }
  }
</script>