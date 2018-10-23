<template>
<<<<<<< HEAD
   <div>
      <div class="container-fluid">
         <div class="ft-page messages">
            <h4 class="header">CAREER STATISTICS</h4>
            <b-row>
               <b-col lg="12" md="12">
                  <div class="left_arrow_line2"><img src="../../../img/left_img.png"></div>
                  <div class="time_div1">
                     <div class="time_div1_img"><img src="../../../img/edit_icon.png"></div>
                     <p>PUBLISHA NEW POST</p>
                  </div>
                  <div class="time_div2">
                     <div class="time_div2_img"><img src="../../../img/data.png"></div>
                     <p>UPLOAD APICTURE</p>
                  </div>
               </b-col>
               <b-col lg="12" md="12">
                  <div class="search_box2">
                     <div class="clear"></div>
                     <div class="profile_div">
                        <div class="profile_box">
                           <div class="Pellentesque-arrow-right"></div>
                           <div class="message_cont">
                              <div class="message">
                                 <div class="typename_div">Type a name</div>
                                 <div class="message_input_div">
                                    <a href="#"><img src="../../../img/puls.png"></a>
                                    <input placeholder="Write a message..." type="text">
                                 </div>
                              </div>
                              <div class="clear"></div>
                           </div>
                        </div>
                     </div>
                     <div>&nbsp;</div>
                     <div>&nbsp;</div>
                  </div>
               </b-col>
            </b-row>
            <router-view v-if="currentChatWith"></router-view>
         </div>
=======
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="spaced-title">Messages</h4>
        <router-view v-if="currentChatWith"></router-view>
>>>>>>> [Resolves #151936872] Contact support page
      </div>
      <messages-sidebar :currentChatWith="currentChatWith" />
   </div>
</template>
<style lang="scss" scoped>
   @import '~stylesheets/variables';
   @import '~stylesheets/common_style';
   body {
   min-height: 0;
   height: auto;
   }
   .left_arrow_line2 {
   width: 50px;
   float: left;
   }
   .time_div1 {
   float: left;
   width: 172px;
   margin-top: 4px;
   }
   .time_div1_img {
   width: 38px;
   float: left;
   margin-right: 12px;
   }
   .timeline_div p {
   font-size: 14px;
   font-family: ubuntulight;
   font-weight: normal;
   color: #929292;
   letter-spacing: 4px;
   }
   .time_div2 {
   float: left;
   width: 172px;
   margin-top: 4px;
   }
   .time_div2_img {
   width: 38px;
   margin-right: 12px;
   float: left;
   }
   .timeline_div p {
   font-size: 14px;
   font-family: ubuntulight;
   font-weight: normal;
   color: #929292;
   letter-spacing: 4px;
   }
   .search_box2 {
   width: 100%;
   margin-top: 35px;
   float: left;
   }
   .profile_div {
   width: 96%;
   background: url(../../../img/img02.png) repeat-y;
   padding-left: 25px;
   position: relative;
   }
   .profile_box {
   background: #fff;
   border-radius: 5px;
   width: 100%;
   display: inline-block;
   }
   .Pellentesque-arrow-right {
   border-top: 7px solid transparent;
   border-left: 8px solid #a5ce4b;
   float: left;
   margin-left: -13px;
   border-bottom: 7px solid transparent;
   top: 50px;
   position: absolute;
   }
   .message_cont {
   width: 92%;
   margin: auto;
   padding-top: 20px;
   }
   .message {
   margin-top: 100%;
   }
   .typename_div {
   width: 95%;
   border: 1px solid #bfbfbf;
   border-radius: 6px;
   margin-top: 3px;
   color: #bfbfbf;
   padding: 5px 13px;
   font-size: 14px;
   font-family: 'ubuntulight';
   }
   .message_input_div {
   margin: 15px 0;
   }
   .message_input_div input[type="text"] {
   width: 86%;
   float: right;
   border: 1px solid #bfbfbf;
   border-radius: 5px;
   padding: 6px 10px;
   margin-top: 3px;
   }
</style>
<script>
   import { mapGetters, mapActions } from 'vuex';
   import MessagesSidebar from 'app/components/MessagesSidebar.vue';
   
   export default {
     name: 'Messages',
     components: {
       'messages-sidebar': MessagesSidebar,
     },
     computed: {
       ...mapGetters(['messages', 'user', 'token']),
       currentChatWith() {
         return this.$route.params.id;
       },
     },
     methods: {
       ...mapActions(['reloadConversation', 'sendMessage']),
     },
   };
</script>