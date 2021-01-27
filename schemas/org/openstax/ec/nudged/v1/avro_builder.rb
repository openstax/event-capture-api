namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'

record :nudged_v1 do
  extends :base_web_event
  required :app, :string
  required :target, :string
  required :context, :string
  required :flavor, :string
  required :medium, :string
  required :occurred_at, :timestamp
end
