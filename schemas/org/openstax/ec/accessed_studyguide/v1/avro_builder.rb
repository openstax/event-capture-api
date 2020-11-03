namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'

record :accessed_studyguide_v1 do
  required :user_uuid, :uuid
  required :page_id, :string
  required :book_id, :string
  required :occurred_at, :timestamp
  required :session_uuid, :uuid
  required :session_order, :int
end
