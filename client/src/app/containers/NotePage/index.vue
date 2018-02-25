<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page note" v-if="{loaded}">
        <h4 class="header">{{ note.value.name }}</h4>
          <span v-for="tag in note.value.tags" :key="tag" v-on:click="getNotesByTag(tag)">
            {{ tag }}
          </span>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import Note from '../NotesPage/components/Note';

export default {
  name: 'NotePage',
  props: ['id'],
  components: {
    sidebar: NotificationSidebar,
    note: Note,
  },
  computed: {
    ...mapGetters(['token', 'note']),
    loaded() {
      return this.note.status === ASYNC_SUCCESS;
    },
  },
  methods: {
    ...mapActions(['getNote']),
    getNotesByTag(tag){
      this.$router.push(`/notes/tags/${tag}`);
    }
  },
  mounted() {
    this.getNote({ token: this.token.value, id: this.id });
  },
};
</script>