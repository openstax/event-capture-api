namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'

record :nudged_v1 do
  required :user_uuid, :uuid
  required :app, :string
  required :target, :string
  required :context, :string
  required :flavor, :string
  required :medium, :string
  required :occurred_at, :timestamp
end
