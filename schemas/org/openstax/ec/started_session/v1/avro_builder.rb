namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'

record :started_session_v1 do
  required :user_uuid, :uuid
  required :ip_address, :string
  required :referrer, :string
  required :user_agent, :string
  required :session_uuid, :uuid
  required :occurred_at, :timestamp
end
