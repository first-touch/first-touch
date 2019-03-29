namespace :notification_templates do
  namespace :email do
    desc 'Seed email templates from db/email_templates.yml file'
    task seed: [:environment] do
      puts 'Seeding email templates'
      email_templates = YAML.load_file Rails.root.join('db', 'email_templates.yml')

      email_templates.each do |email_template|
        template = EmailTemplate.where(ref: email_template['ref'])
        EmailTemplate.create(email_template) unless template.present?
      end
      puts 'Completed seeding email templates'
    end
  end

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

  desc 'This seeds both email and app notification templates'
  task :seed do
    Rake::Task['notification_templates:email:seed'].invoke
    Rake::Task['notification_templates:app_notification:seed'].invoke
  end
end
