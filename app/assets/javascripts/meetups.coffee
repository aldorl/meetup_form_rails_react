# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

DOM = React.DOM

monthName = (monthNumberStartingFromZero) ->
    [
        "January", "February", "March", "April", "May", "June", "July",
        "August", "September", "October", "November", "December"
    ][monthNumberStartingFromZero]

dayName = (date) ->
    dayNameStartingWithSundayZero = date.getDay()
    [
        "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ][dayNameStartingWithSundayZero]

DateWithLabel = React.createClass
    getDefaultProps: ->
        date: new Date()

    onYearChange: (event) ->
        newDate = new Date(
            event.target.value,
            @props.date.getMonth(),
            @props.date.getDate()
        )
        @props.onChange(newDate)

    onMonthChange: (event) ->
        newDate = new Date(
            @props.date.getFullYear(),
            event.target.value,
            @props.date.getDate()
        )
        @props.onChange(newDate)

    onDateChange: (event) ->
        newDate = new Date(
            @props.date.getFullYear(),
            @props.date.getMonth(),
            event.target.value
        )
        @props.onChange(newDate)

    render: ->
        DOM.div
            className: "form-group"
            DOM.label
                className: "col-lg-2 control-label"
                "Date"
            DOM.div
                className: "col-lg-2"
                DOM.select
                    className: "form-control"
                    onChange: @onYearChange
                    value: @props.date.getFullYear()
                    DOM.option(value: year, key: year, year) for year in [2015..2020]

            DOM.div
                className: "col-lg-3"
                DOM.select
                    className: "form-control"
                    onChange: @onMonthChange
                    value: @props.date.getMonth()
                    DOM.option(value: month, key: month, "#{month+1}-#{monthName(month)}") for month in [0..11]

            DOM.div
                className: "col-lg-2"
                DOM.select
                    className: "form-control"
                    onChange: @onDateChange
                    value: @props.date.getDate()
                    for day in [1..31]
                        date = new Date(
                            @props.date.getFullYear(),
                            @props.date.getMonth(),
                            day
                        )
                        DOM.option(value: day, key: day, "#{day}-#{dayName(date)}")

dateWithLabel = React.createFactory(DateWithLabel)

FormInputWithLabel = React.createClass
    getDefaultProps: ->
        elementType: "input"
        inputType: "text"

    displayName: "FormInputWithLabel"

    tagType: ->
        {
            "input":    @props.inputType,
            "textarea": null,
        }[@props.elementType]

    render: ->
        DOM.div
            className: "form-group"
            DOM.label
                htmlFor: @props.id
                className: "col-lg-2 control-label"
                @props.labelText
            DOM.div
                className: "col-lg-10"
                DOM[@props.elementType]
                    className: "form-control"
                    placeholder: @props.placeholder
                    id: @props.id
                    type: @tagType()
                    value: @props.value
                    onChange: @props.onChange

formInputWithLabel = React.createFactory(FormInputWithLabel)

window.CreateNewMeetupForm = React.createClass
    getInitialState: ->
        {
            meetup: {
                title: "",
                description: "",
                date: new Date()
            }
        }

    titleChanged: (event) ->
        @state.meetup.title = event.target.value
        @forceUpdate()

    descriptionChanged: (event) ->
        @state.meetup.description = event.target.value
        @forceUpdate()

    dateChanged: (newDate) ->
        @state.meetup.date = newDate
        @forceUpdate()

    formSubmitted: (event) ->
        event.preventDefault()
        meetup = @state.meetup

        $.ajax
            url: "/meetups.json"
            type: "POST"
            dataType: "JSON"
            contentType: "application/json"
            processData: false
            data: JSON.stringify({meetup: {
                title: meetup.title
                description: meetup.description
                date: "#{meetup.date.getFullYear()}-#{meetup.date.getMonth()+1}-#{meetup.date.getDate()}"
            }})

    render: ->
        DOM.form
            onSubmit: @formSubmitted
            className: "form-horizontal"
            # method: "post"
            # action: "/meetups"

            DOM.fieldset null,
                DOM.legend null, "New Meetup"

                formInputWithLabel
                    id: "title"
                    value: @state.meetup.title
                    onChange: @titleChanged
                    placeholder: "Meetup title"
                    labelText: "Title"

                formInputWithLabel
                    id: "description"
                    value: @state.meetup.description
                    onChange: @descriptionChanged
                    placeholder: "Meetup description"
                    labelText: "Description"
                    elementType: "textarea"

                dateWithLabel
                    onChange: @dateChanged
                    date: @state.meetup.date

                DOM.div
                    className: "form-group"
                    DOM.div
                        className: "col-lg-10 col-lg-offset-2"
                    DOM.button
                        type: "submit"
                        className: "btn btn-primary"
                        "Save"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
