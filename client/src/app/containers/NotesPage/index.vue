<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page notes">
        <h4 class="header">Notes</h4>
        <note v-for="note in notebook" :info="note" :key="note.id"/>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import Note from './components/Note';

export default {
  name: 'NotesPage',
  components: {
    sidebar: NotificationSidebar,
    note: Note,
  },
  computed: {
    ...mapGetters(['token', 'note']),
    loading() {
      return this.note.status === ASYNC_LOADING;
    },
    notebook() {
      return this.note.value;
    },
  },
  methods: {
    ...mapActions(['getNotes']),
  },
  mounted() {
    this.getNotes({ token: this.token.value });
  },
};
</script>