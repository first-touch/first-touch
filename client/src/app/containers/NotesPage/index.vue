<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page notes">
        <h4 class="header">Notes</h4>
        <div class="row">
          <note v-for="note in notebook" :info="note" :noteFn="getNotesByTag" :key="note.id"/>
        </div>
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
    getNotesByTag(tag){
      let token = this.token.value;
      this.$store.dispatch('getNotesByTag', { token, tag })
    }
  },
  mounted() {
    this.getNotes({ token: this.token.value });
  },
};
</script>