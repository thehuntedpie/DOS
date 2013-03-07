nativePull = coroutine.yield

local inputs = {}

function nextInput()
	event, p1, p2, p3, p4, p5 = inputs[1][1], inputs[1][2], inputs[1][3], inputs[1][4], inputs[1][5]
	for i, v in ipairs(inputs) do
		inputs[i] = inputs[i + 1]
	end
	return event, p1, p2, p3, p4, p5
end

os.pullEvent = function()
	event = {nextInput()}
	if event[1] == "terminated" then
		error("Terminated")
	else
		return event[1], event[2], event[3], event[4], event[5]
	end
end

os.pullEventRaw = function()
	return nextInput()
end

while true do
	event, p1, p2, p3, p4, p5 = nativePull()

	for i, #inputs do
		if inputs[i + 1] == nil then
			inputs[i + 1] = {event, p1, p2, p3, p4, p5}
			break
		end
	end
end
