<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page notes">
        <h4 class="spaced-title">Notes</h4>
        <div class="row" v-if="{loaded}">
          <note v-for="note in notebook" :info="note" :noteFn="getNotesByTag" :key="note.id"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import NotificationSidebar from 'app/components/NotificationSidebar';
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
    loaded() {
      return this.note.status === ASYNC_SUCCESS;
    },
    notebook() {
      return this.note.value;
    }
  },
  methods: {
    ...mapActions(['getNotes']),
    getNotesByTag(tag){
      this.$router.push(`/notes/tags/${tag}`);
    }
  },
  mounted() {
    this.getNotes({ token: this.token.value });
  },
};
</script>
