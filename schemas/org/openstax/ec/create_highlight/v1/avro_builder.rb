namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'

record :create_highlight_v1 do
  required :user_uuid, :uuid
  required :contents, :string
  required :location, :string
  required :color, :string
  required :occurred_at, :timestamp
end
