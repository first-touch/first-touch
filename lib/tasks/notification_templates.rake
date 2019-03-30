namespace :notification_templates do
  namespace :app_notification do
    desc 'Seed app notifications templates from db/app_notification_templates.yml file'
    task seed: [:environment] do
      puts 'Seeding app notification templates'
      app_notification_templates = YAML.load_file Rails.root.join(
        'db', 'app_notification_templates.yml'
      )

      app_notification_templates.each do |app_notification_template|
        template = AppNotificationTemplate.where(ref: app_notification_template['ref'])
        AppNotificationTemplate.create(app_notification_template) unless template.present?
      end
      puts 'Completed seeding app notification templates'
    end
  end
end
