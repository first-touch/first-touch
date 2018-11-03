<template>
  <div v-if="requestValue">
    <h4 class="spaced-title upper-cased main-color">Request</h4>
    <action-item>
      <button class="timeline-widget-button" @click="newPlayerRequest">
        <span class="newRequest">
          <icon name="edit" scale="1.5"></icon>
        </span>
        <a>New Player Job Request</a>
      </button>
      <button class="timeline-widget-button button-right" v-if="requestValue.status == 'publish'" @click="updateStatus('private')">
        <span class="unpublish">
          <icon name="eye-slash" scale="1.5"></icon>
        </span>
        <a>Unpublish Request</a>
      </button>
      <button class="timeline-widget-button button-right" v-if="requestValue.status == 'private'" @click="updateStatus('publish')">
        <span class="publish">
          <icon name="eye" scale="1.5"></icon>
        </span>
        <a>Publish Request</a>
      </button>
    </action-item>
    <timeline-item>
      <request :key="request.id" :request="requestValue" :viewSummary="viewSummary" class="onlyone"></request>
      <b-modal class="ft-modal" size="lg" ref="requestModal">
        <div>
          <playerrequestpopup v-if="requestValue.type_request == 'player' " :request="requestValue" :closeAction="closeAction" />
          <teamrequestpopup v-if="requestValue.type_request == 'team' " :request="requestValue" :closeAction="closeAction" />
          <positionrequestpopup v-if="requestValue.type_request == 'position' " :request="requestValue" :closeAction="closeAction"
          />
        </div>
      </b-modal>
    </timeline-item>
  </div>
</template>

<script>
  import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
  import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
  import TeamRequestPopup from 'app/components/RequestPopup/TeamRequestPopup';
  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/eye';
  import 'vue-awesome/icons/eye-slash';
  import Icon from 'vue-awesome/components/Icon';
  import ActionsItem from 'app/components/ActionsItem';
  import RequestItem from 'app/components/RequestItem';
  import TimelineItem from 'app/components/TimelineItem';

  export default {
    name: 'ProposedRequestItem',
    props: ['request', 'updateStatus'],
    components: {
      'action-item': ActionsItem,
      'timeline-item': TimelineItem,

      request: RequestItem,
      teamrequestpopup: TeamRequestPopup,
      playerrequestpopup: PlayerRequestPopup,
      positionrequestpopup: PositionRequestPopup,
      icon: Icon,
    },
    computed: {
      requestValue() {
        return (this.request.value);
      }
    },
    methods: {
      closeAction(request) {
        this.$refs.requestModal.hide();
      },
      newPlayerRequest() {
        this.$router.push({
          name: 'clubRequestList',
          params: {
            type: 'player'
          }
        });
      },
      viewSummary(request) {
        this.$refs.requestModal.show();
      },
    }
  }
</script>
