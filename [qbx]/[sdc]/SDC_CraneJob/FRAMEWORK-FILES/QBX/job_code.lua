-- Put these jobs into your qbx-core/shared/jobs.lua

['cranejob'] = {
	label = 'Lift Tech',
	defaultDuty = true,
	offDutyPay = false,
	grades = {
        ['0'] = {
            name = 'Crane Operator',
            payment = 0
        }
    },
},