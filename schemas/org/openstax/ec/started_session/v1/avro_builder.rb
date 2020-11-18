namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/device'
import 'types/session'

record :started_session_v1 do
  extends :device
  extends :session
  required :user_uuid, :uuid
  required :ip_address, :string
  required :referrer, :string
  required :user_agent, :string
  required :occurred_at, :timestamp
end
