namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/who_am_i'
import 'types/ordered_session'
import 'types/source_uri'

record :nudged_v1 do
  extends :who_am_i
  extends :ordered_session
  extends :source_uri
  required :app, :string
  required :target, :string
  required :context, :string
  required :flavor, :string
  required :medium, :string
  required :occurred_at, :timestamp
end
