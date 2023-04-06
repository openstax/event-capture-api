namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/who_am_i'
import 'types/session'
import 'types/source_uri'

record :started_session_v1 do
  extends :who_am_i
  extends :session
  extends :source_uri
  required :ip_address, :string
  required :referrer, :string
  required :user_agent, :string
  required :occurred_at, :timestamp
  optional :platform, :string
  optional :release_id, :string
  optional :service_worker, :string
end
