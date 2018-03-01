<template>
  <div :class="{ active: active }">
    <slot name="input"></slot>
    <span @click.prevent="activate">
      <slot name="icon"></slot>
    </span>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        active: false
      }
    },

    methods: {
      activate() {
        this.active = true
      }
    }
  }
</script>