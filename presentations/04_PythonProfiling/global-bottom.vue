<template>
  <footer
    v-if="$slidev.nav.currentPage !== 1"
    class="absolute bottom-0 right-0 p-2 text-gray-400"
  >
    <SlideCurrentNo />
  </footer>
</template>
