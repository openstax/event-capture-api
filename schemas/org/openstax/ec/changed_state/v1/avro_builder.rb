namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'

record :changed_state_v1 do
  extends :base_web_event
  required :state_type, :string
  required :current, :string
  required :previous, :string
  required :occurred_at, :timestamp
end


