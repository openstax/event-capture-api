namespace 'org.openstax.ec'

# TODO put this and other common types in a shared / imported file
fixed :uuid, 16

record :nudged_v1 do
  required :user_uuid, :uuid
  required :app, :string
  required :target, :string
  required :context, :string
  required :flavor, :string
  required :medium, :string
  required :occurred_at_time_in_browser, :string
end
