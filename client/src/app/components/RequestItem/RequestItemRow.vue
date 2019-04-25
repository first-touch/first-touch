<template>
<tr class="request-tr table-item">
  <td v-for="field in widgets" :key="field.id">
    <span v-if="field == 'id'" class="contents">
      {{request.id | requestId(request.type_request) }}
    </span>
    <span v-if="field == 'type'" class="contents">
      <p class="capitalize">
        {{ request.type_request }} job request
      </p>
    </span>
    <span v-if="field == 'created_at'" class="contents">
      {{ request.created_at | moment }}
    </span>
    <span v-if="field == 'status'" class="contents">
      <span v-if="request.status == 'publish'" class="published">
        Published
      </span>
      <span v-else class="private">
        Unpublished
      </span>
    </span>
    <span v-if="field == 'club'" class="contents">
      {{ request.club.name }}
    </span>
    <span v-if="field == 'deadline'" class="contents">
      {{ request.deadline | moment }}
    </span>
    <span v-if="field == 'bid_status'" class="contents">
      <p class="capitalize">
        {{ request.bid_status}}
      </p>
    </span>
    <span v-if="field == 'bid_price'" class="contents">
      <span v-if="position">
        From {{request.price.value}} to {{request.price.max}} {{request.price.currency}}
      </span>
      <span v-if="!position">
        {{request.bid_price.value}} {{request.price.currency}}
      </span>
    </span>
    <span v-if="field == 'bids'" class="contents">
      {{request.request_bids_count}}
    </span>
    <span v-if="field == 'action'" class="contents">
      <div class="table-action">
        <div class="first-action buttons-inner">
          <router-link v-if="canAction(own && !position, 'view_bids', true)" :to="{ name: 'clubRequestBids', params: { id: request.id }}"
            class="ft-action">
            <button class="btn-round">View Bids</button>
          </router-link>
          <router-link v-if="canAction(own && position, 'view_proposed', true)" :to="{ name: 'clubReportProposed', params: { requestId: request.id }}"
            class="ft-action">
            <button class="btn-round">View Proposed Reports</button>
          </router-link>
          <a v-if="canAction(!own && !position && addBid, 'bid',true)" @click="addBid(request)" class="ft-action">
            <button class="btn-round" v-if="bidStatus == 'U'">Update Bid</button>
            <button class="btn-round" v-if="bidStatus == 'N'">Bid</button>
          </a>
          <a v-if="canAction(!own && !haveBid && position && addBid, 'to_job', true)" class="ft-action" @click="addBid(request)">
            <button class="btn-round">+ To job list</button>
          </a>
          <a v-if="canAction(bidStatus == 'C' && typeof createReport !== 'undefined' , 'create_report', true)" class="ft-action" @click="createReport(request)">
            <button class="btn-round">Create Report</button>
          </a>
          <a v-if="canAction(bidStatus == 'C' && typeof cancelReport !== 'undefined' , 'cancel_report', true)" @click="cancelReport(request)">
            <button class="btn-round">Cancel Report</button>
          </a>
          <a v-if="canAction(bidStatus == 'R' && typeof viewReport !== 'undefined', 'view_report', true)" @click="viewReport(request.report_id)">
            <button class="btn-round">View Report</button>
          </a>
          <a v-if="canAction(!own, 'view_details', true)" @click="viewSummary(request)">
            <button class="btn-round">View Details</button>
          </a>
          <a v-if="canAction(request.status == 'publish' && own, 'unpublish', true)" @click="update(request.id, 'private')">
            <button class="btn-round">Unpublish</button>
          </a>
          <a v-if="canAction(request.status == 'private' && own, 'publish', true)" @click="update(request.id, 'publish')">
            <button class="btn-round"> Publish</button>
          </a>
          <a v-if="canAction(own, 'delete', true)" @click="update(request.id, 'deleted')">
            <button class="btn-round"> Delete</button>
          </a>
          <router-link v-if="canAction(own, 'edit', true)" :to="{ name: 'clubRequest', params: { id: request.id }}">
            <button class="btn-round"> Edit</button>
          </router-link>
        </div>
        <div class="" v-if="listAction">
          <div class="more">
            <icon name="ellipsis-v"></icon>
            <div class="action">
              <div class="content" ref="listAction">
                <a v-if="canAction(bidStatus == 'C' && typeof cancelReport !== 'undefined', 'cancel_report', false)" @click="cancelReport(request)">
                  Cancel Report
                </a>
                <a v-if="canAction(bidStatus == 'R' && typeof viewReport !== 'undefined', 'view_report', false)" @click="viewReport(request.report_id)">
                  View Report
                </a>
                <a v-if="canAction(!own, 'view_details', false)" @click="viewSummary(request)">
                  View Details
                </a>
                <a v-if="canAction(request.status == 'publish' && own, 'unpublish', false)" @click="unpublishItem(request.id)">
                  Unpublish
                </a>
                <a v-if="canAction(request.status == 'private' && own, 'publish', false)" @click="publishItem(request.id)">
                  Publish
                </a>
                <a v-if="canAction(own, 'delete', false)" @click="deleteItem(request.id)">
                  Delete
                </a>
                <router-link v-if="canAction(own, 'edit', false)" :to="{ name: 'clubRequest', params: { id: request.id }}">
                  Edit
                </router-link>
              </div>
              <span class="down-arrow"></span>
            </div>
          </div>
        </div>
      </div>
    </span>

  </td>
</tr>
</template>

<script>
import Vue from 'vue';
import RequestItemBase from "./RequestItemBase";
import 'vue-awesome/icons/ellipsis-v';
import Icon from 'vue-awesome/components/Icon';

export default Vue.extend({
  mixins: [RequestItemBase],
  components: {
    Icon
  }

})
</script>

<style lang="scss" scoped>
  @import '~stylesheets/light_item';
  @import '~stylesheets/variables';
  .capitalize:first-letter {
    text-transform: capitalize;
  }

  .table-action {
    display: flex;
    align-items: center;
    justify-content: flex-end;

    .col {
      &.first-action {
        float: left;
        padding: 0;
        button {
          margin: 0;
        }
      }
    }
  }

  .contents {
    display: contents;
  }
</style>
