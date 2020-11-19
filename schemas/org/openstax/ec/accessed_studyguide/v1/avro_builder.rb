namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/who_am_i'
import 'types/ordered_session'

record :accessed_studyguide_v1 do
  extends :who_am_i
  extends :ordered_session
  required :page_id, :string
  required :book_id, :string
  required :occurred_at, :timestamp
end
