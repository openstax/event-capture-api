namespace 'org.openstax.interactions'

fixed :uuid, 16

record :nudged do
  required :user_uuid, :uuid
  required :app, :string
  required :target, :string
  required :context, :string
  required :flavor, :string
  required :medium, :string
  required :occurred_at_time_in_browser, :string
end
