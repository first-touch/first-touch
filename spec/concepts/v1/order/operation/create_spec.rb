# commented out this code cause this operation doesnt even exist
# require 'rails_helper'
#
# describe V1::Order::Create do
#   let(:current_user) do
#     res = V1::User::Register.(
#       params: {
#         email: 'test@banaas.com',
#         password: '123123',
#         password_confirmation: '123123',
#         role_name: 'scout',
#         personal_profile: {
#           first_name: 'Test',
#           last_name: 'Bananas',
#           birthday: '10/01/1989'
#         }
#       }
#     )
#     res[:model]
#   end
#
#   let!(:report_good) do
#     res = V1::Report::Create.(
#       params: {
#         headline: 'The new ronaldo',
#         price: 20,
#         type_report: 'player',
#         status: 'publish'
#       },
#       current_user: current_user
#     )
#     res[:model]
#   end
#
#   let!(:report_good2) do
#     res = V1::Report::Create.(
#       params: {
#         headline: 'The new ronaldo',
#         price: 20,
#         type_report: 'player',
#         status: 'publish'
#       },
#       current_user: current_user
#     )
#     res[:model]
#   end
#
#   let(:user_customer) do
#     create :user_customer
#   end
#
#   let(:order) do
#     debugger
#
#     res = V1::Order::Create.(
#       params: {
#         customer: user_customer,
#         report_id: report_good.id
#       },
#       status: 'completed',
#       current_user: current_user
#     )
#     res[:model]
#   end
#
#   let(:order_twins) do
#     res = V1::Order::Create.(
#       params: {
#         customer: user_customer,
#         report_id: report_good.id
#       },
#       status: 'completed',
#       current_user: current_user
#     )
#     res[:model]
#   end
#
#   let(:order2) do
#     res = V1::Order::Create.(
#       params: {
#         customer: user_customer,
#         report_id: report_good2.id
#       },
#       status: 'completed',
#       current_user: current_user
#     )
#     res[:model]
#   end
#
#   describe 'when order is valid' do
#     let(:report) { report_good }
#     it 'succeed to register the order' do
#       expect(order).to be_persisted
#     end
#   end
#
#   describe 'order should be unique (report_id, customer_id)' do
#     let(:report) { report_good }
#
#     it 'succeed to persist a new order but failed to register order on the same report twice' do
#       expect(order).to be_persisted
#       expect(order2).to be_persisted
#       expect(order_twins).to_not be_persisted
#     end
#   end
# end
