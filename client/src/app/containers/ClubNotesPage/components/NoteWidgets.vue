<template>
  <div>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :on-click="openAddNoteModal" icon="ft-notes">Add Note</ft-button>
      <ft-button :on-click="createCategory" icon="ft-notes">Create a Category</ft-button>
    </div>
    <b-modal ref="newNoteModal" id="add-modal" size="lg" hide-footer hide-header centered>
      <div class="header">
        <div class="left">
        <h3 class="name">Add a new note</h3>
        </div>
        <div class="right">
          <select class="privacy">
            <option>Private</option>
            <option>Public</option>
          </select>
          <button class="a-bar-button">Publish</button>
          <button class="a-bar-button reverse" @click="closeAddNoteModal">Close</button>
        </div>
      </div>
      <div class="body">
        <form class="form">
          <input class="title" placeholder="Title" required/>
          <div class="separator"></div>
          <textarea class="content" rows="7" placeholder="Content" required/>
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
    .right {
      .privacy{
        height: 30px;
        line-height: 20px;
        border-radius: 4px;
        border: 1px solid $main-text-color;
        margin-left: 10px;
        color: $main-text-color;
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
  methods: {
    openAddNoteModal() {
      this.$refs.newNoteModal.show()
    },
    closeAddNoteModal() {
      this.$refs.newNoteModal.hide()
    },
    createCategory() {
      console.log("to be implemented");
    }
  }
};
</script>
