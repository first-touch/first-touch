<template>
  <div>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :on-click="openAddNoteModal" icon="ft-notes">Add Note</ft-button>
      <ft-button :on-click="createCategory" icon="ft-notes">Create a Category</ft-button>
    </div>
    <b-modal ref="newNoteModal" id="add-modal" size="lg" hide-footer hide-header centered>
      <div class="row">
        <div class="col-lg-4">
          <h3 class="name">Add a new note</h3>
        </div>
        <div class="col-lg-8">
          <div class="form-inline float-right">
            <div class="form-group mx-1">
              <select class="form-control" v-model="notePrivacy">
                <option v-for="option in privacyOptions" v-bind:value="option.value" v-bind:key="option.value">
                  {{ option.text }}
                </option>
              </select>
            </div>
            <div class="form-group mx-1">
              <button class="form-control a-bar-button" @click="publishNote">Publish</button>
            </div>
            <div class="form-group mx-1">
              <button class="form-control a-bar-button reverse" @click="closeAddNoteModal">Close</button>
            </div>
          </div>
        </div>
      </div>
      <div class="body">
        <form class="form">
          <input class="title" placeholder="Title" required v-model="noteName" />
          <div class="separator"></div>
          <textarea class="content" rows="7" placeholder="Content" required v-model="noteContent"/>
        </form>
      </div>
    </b-modal>
  </div>
</template>

<style lang="scss">
@import '~stylesheets/variables.scss';

#add-modal {
  color: $main-text-color;

  .header {
    display: flex;
    justify-content: space-between;
    .left {
      .name {
        text-transform: uppercase;
      }
    }
  }
  .body {
    .form {
      display: flex;
      flex-direction: column;
      .title,
      .content {
        border: none;
        padding: 10px 0;
        &:focus {
          border: none;
          box-shadow: none;
          outline: none;
        }
      }
      .title {
        font-size: 2rem;
      }
      .content {
        font-size: 1.2rem;
      }
      .separator:before {
        content: '';
        position: absolute;
        margin-top: -2px;
        width: 10%;
        border-top: 1px solid $main-text-color;
      }
    }
  }
}
</style>

<script>
import Button from 'app/components/Button/Button';

export default {
  name: 'NoteWidget',
  components: {
    'ft-button': Button
  },
  data(){
    return {
      noteName : '',
      noteContent : '',
      notePrivacy : 'private',
      privacyOptions: [
        { text: 'Private', value: 'private' },
        { text: 'Public', value: 'public' }
      ]
    }
  },
  methods: {
    openAddNoteModal() {
      this.$refs.newNoteModal.show()
    },
    closeAddNoteModal() {
      this.$refs.newNoteModal.hide()
    },
    createCategory() {
      console.log("to be implemented");
    },
    publishNote() {
      let noteData = {
        name: this.noteName,
        content: this.noteContent
      }
      this.$store.dispatch('club/notes/create', noteData).then(() => {
        this.closeAddNoteModal();
      });
    }
  }
};
</script>
