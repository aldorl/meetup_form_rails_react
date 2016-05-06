# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

DOM = React.DOM

FormInputWithLabel = React.createClass
    getDefaultProps: ->
        elementType: "input"
        inputType: "text"
    displayName: "FormInputWithLabel"
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
    tagType: ->
        {
            "input":    @props.inputType,
            "textarea": null,
        }[@props.elementType]

formInputWithLabel = React.createFactory(FormInputWithLabel)

window.CreateNewMeetupForm = React.createClass
    getInitialState: ->
        {
            meetup: {
                title: "",
                description: "",
            }
        }

    titleChanged: (event) ->
        @state.meetup.title = event.target.value
        @forceUpdate()

    descriptionChanged: (event) ->
        @state.meetup.description = event.target.value
        @forceUpdate()

    render: ->
        DOM.form
            className: "form-horizontal"
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

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
