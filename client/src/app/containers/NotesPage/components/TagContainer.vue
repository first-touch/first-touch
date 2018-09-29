<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page notes">
        <h4 class="spaced-title">Notes</h4>
        <div class="row">
          <h5 class="col-12">
            Showing Notes Tagged by: {{ tag }}
          </h5>
          <note v-show="{loaded}" v-for="note in notebook" :info="note" :noteFn="redirect" :key="note.id"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import NotificationSidebar from '../../../components/NotificationSidebar.vue';
import { ASYNC_SUCCESS } from '../../../constants/AsyncStatus';
import Note from './Note.vue';

export default {
  name: 'TagContainer',
  props: ['tag'],
  components: {
    sidebar: NotificationSidebar,
    note: Note,
  },
  computed: {
    ...mapGetters(['token', 'note']),
    loaded() {
      return this.note.status === ASYNC_SUCCESS
    },
    notebook() {
      return this.note.value;
    },
  },
  methods: {
    ...mapActions(['getNotesByTag']),
    redirect(tag){
      this.$router.push(`/notes/tags/${tag}`);
    }
  },
  mounted() {
    this.getNotesByTag({ token: this.token.value, tag: this.tag });
  },
};
</script>
