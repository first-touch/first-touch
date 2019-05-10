<template>
  <div class="ft-page timeline">
    <h4 class="spaced-title upper-cased main-color">Notes</h4>
    <note-widget/>
    <timeline-item>
      <div class="row">
        <div class="col-lg-2">
          <h6 class="notelist-title">Note Count</h6>
          <h1 class="notelist-count"> {{ allNotes().length }} </h1>
        </div>
        <div class="col-lg-10">
          <div class="row">
            <div class="col-lg-4">
              <select class="form-control col-lg-12">
                <option disabled value="all" selected>All</option>
                <option>Something</option>
              </select>
            </div>
            <div class="col-lg-4">
              <select class="form-control col-lg-12">
                <option disabled value="all" selected>Date</option>
                <option>Something</option>
              </select>
            </div>
            <div class="col-lg-4">
              <form>
                <input type="text" class="form-control col-lg-12" placeholder="Search tags"/>
              </form>
            </div>
          </div>
        </div>
      </div>
      <note v-for="note in allNotes()" v-bind:note="note" :key="note.id"/>
    </timeline-item>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .notelist-title {
    color: $main-text-color;
    font-size: 0.95em;
    text-transform: uppercase;
  }
  .notelist-count {
    color: $main-header-color;
    font-size: 4em;
    text-align: center;
  }
</style>

<script>
  import { mapGetters } from 'vuex'
  import NoteWidgets from 'app/components/Notes/NoteWidgets';
  import TimelineItem from 'app/components/TimelineItem';
  import Note from 'app/components/Notes/Note';

  export default {
    name: 'ClubNotesPage',
    components: {
      NoteWidgets,
      TimelineItem,
      Note,
    },
    methods: {
      ...mapGetters('club/notes/', ['allNotes'])
    },
    created() {
      this.$store.dispatch('club/notes/index');
    }
  };
</script>
