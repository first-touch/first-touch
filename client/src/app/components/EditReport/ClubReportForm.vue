<template>
  <div>
    <form @submit.prevent id="report-form">
      <div class="form-group row">
        <div class="col-sm-10">
          <label class="col-form-label">Report Name</label>
          <input type="text" class="col-md-6" v-model="headline">
        </div>
      </div>
      <div class="form-group">
        <label class=" col-md-12">Analysis of Trainings/Matches</label>
        <matchanalyzed :analyzed_matches="meta_data.analyzed_matches" type="team"/>
      </div>
      <div class="form-group col-md-12">
        <label>Formation(s) Used & Playing Style</label>
        <div class="row">
          <textarea v-model="meta_data.formation" class="col col-md-8 text-input" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Attacking organisation & Transition After Winning Possession</label>
        <div class="row">
          <textarea v-model="meta_data.attacking_organisation" class="col col-md-8 text-input" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Defensive Organisation & Transition After Losing Possession</label>
        <div class="row">
          <textarea v-model="meta_data.defensive_organisation" class="col col-md-8 text-input" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Set plays - For</label>
        <div class="row">
          <textarea v-model="meta_data.setplays_for" class="col col-md-8" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Set plays - Against</label>
        <div class="row">
          <textarea v-model="meta_data.setplays_against" class="col col-md-8" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Main threats</label>
        <div class="row">
          <textarea v-model="meta_data.main_threats" class="col col-md-8" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Other Observations & Viewpoints to Note</label>
        <div class="row">
          <textarea v-model="meta_data.observations" class="col col-md-8" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Conclusions</label>
        <div class="row">
          <textarea v-model="meta_data.conclusions" class="col col-md-8" />
        </div>
      </div>
      <div class="form-group row attachments-div">
        <label class="col-md-12 col-form-label">Attachments:</label>
        <div class="col-md-12">
          <input type="file" name="files" ref="myFiles" @change="previewFiles" multiple class="col-md-4">
          <ul class="col-md-6">
            <li class="list" v-for="file in files" :key="file.id"> {{file.name}} </li>
          </ul>
        </div>
      </div>
      <div v-if="report">
        <div class="form-group row update-attachments" v-for="attachment in report.report_data.attachments.attachments" :key="attachment.id">
          <label class="col-sm-2">Attachment</label>
          <div class="col col-sm-10">
            <p :class="[{ 'removed' : remove_attachment[attachment.id] }, 'filename' ,'col col-sm-7']" :title="attachment.filename">{{attachment.filename}} </p>
            <p class="remove col col-sm-2" @click="removeAttachment(attachment.id)">X</p>
          </div>
        </div>
      </div>
      <div class="form-group col-md-12">
        <div class="row">
          <label class="col-md-2 label-price">Price (in SGD)</label>
          <div class="price-input col-md-6">
            <input type="number" v-model="price" class="form-control" min="0" max="999999" />
            <p v-if="price == 0" class="info">The report will be free</p>
          </div>
        </div>
      </div>
      <div class="form-group buttons">
        <button id="submit" class="btn btn-primary" @click="handleSubmit">Publish</button>
        <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-default">Cancel</button>
      </div>
    </form>

  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.info {
  color: green;
  font-weight: bold;
  margin: 0;
}

#report-form {
  textarea {
    resize: none;
    overflow-y: scroll;
  }
  .text-input {
    height: 100px;
  }
  .price-input {
    max-width: 450px;
  }
  .label-price {
    margin-top: 8px;
  }
  .col-form-label {
    margin-right: 20px;
  }
  label {
    font-size: 13px;
  }
  h3 {
    color: $main-text-color;
    font-size: 15px;
  }
  .list {
    color: #535ee2;
  }
  .attachments-div {
    ul {
      float: right;
      li {
        display: list-item;
        list-style: disc;
      }
    }
  }

  .buttons {
    float: right;
  }
  overflow: hidden;
  .update-attachments {
    color: $main-text-color;
    p {
      display: inline-block;
      &.removed {
        text-decoration: line-through;
      }
      &.remove {
        color: red;
        cursor: pointer;
      }
      &.filename {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
      }
    }
  }
}

.button {
  padding: 10px;
}

.form-group {
  label {
    color: $main-text-color;
  }
  .bar-button {
    color: $main-text-color;
    border: 1px solid $main-text-color;
  }
}
</style>

<script>
import MatchAnalyzed from './MatchAnalyzed';

export default {
  name: 'ClubReportForm',
  props: ['submitReport', 'reportStatus', 'report','cancelAction'],
  components: {
    matchanalyzed: MatchAnalyzed
  },
  data () {
    return {
      files: [],
      meta_data: {
        analyzed_matches: [
          {
            date: '',
            opponent: '',
            venue: '',
            result: ''
          }
        ]
      },
      price: 0,
      headline: '',
      remove_attachment: {}
    };
  },
  methods: {
    removeAttachment (id) {
      if (this.remove_attachment[id] === true) this.remove_attachment[id] = false;
      else {
        var obj = {};
        obj[id] = true;
        this.remove_attachment = Object.assign({}, this.remove_attachment, obj);
      }
    },
    previewFiles () {
      this.files = this.$refs.myFiles.files;
    },
    handleSubmit () {
      var report = {
        headline: this.headline,
        price: this.price,
        report_data: this.meta_data,
        remove_attachment: this.remove_attachment
      };
      this.submitReport(report, this.$refs.myFiles.files);
      $('html, body').animate(
        {
          scrollTop: 0
        },
        100
      );
    }
  },
  mounted () {
    if (this.report) {
      this.meta_data = this.report.report_data.meta_data;
      this.price = this.report.price;
      this.headline = this.report.headline;
    }
  }
};
</script>
