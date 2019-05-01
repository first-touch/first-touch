<template>
  <div>
    <div class="ft-page container">
      <h4 class="spaced-title upper-cased main-color page-title mb-5">Notes</h4>
      <note-widgets></note-widgets>
      <timeline-item>
        <div class="row" v-if="{loaded}">
          <div v-if="hasNotes" class="col-12">
            <note v-for="note in notebook" :note="note" :key="note.id"/>
          </div>
          <div v-else>
            <div class="col-12">
              You have no notes taken. Start by writing your first note here.
            </div>
          </div>
        </div>
      </timeline-item>
    </div>
  </div>
</template>

<script>
import TimelineItem from 'app/components/TimelineItem';
import NoteWidgets from 'app/containers/ClubNotesPage/components/NoteWidgets';
import Note from 'app/containers/ClubNotesPage/components/Note';
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';

export default {
  name: 'NotesPage',
  components: {
    NoteWidgets,
    Note,
    TimelineItem
  },
  computed: {
    ...mapGetters(['token', 'note']),
    loaded() {
      return this.note.status === ASYNC_SUCCESS;
    },
    notebook() {
      return this.note.value;
    },
    hasNotes() {
      return this.notebook.length > 0;
    }
  },
  methods: {
    ...mapActions(['getNotes'])
  },
  mounted() {
    this.getNotes({ token: this.token.value });
  },
};
</script>
