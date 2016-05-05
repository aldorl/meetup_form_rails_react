# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

DOM = React.DOM

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

                DOM.div
                    className: "form-group"
                    DOM.label
                        htmlFor: "title"
                        className: "col-lg-2 control-label"
                        "Title"
                    DOM.div
                        className: "col-lg-10"
                        DOM.input
                            className: "form-control"
                            placeholder: "Meetup title"
                            id: "title"
                            type: "text"
                            value: @state.meetup.title
                            onChange: @titleChanged
                DOM.div
                    className: "form-group"
                    DOM.label
                        htmlFor: "description"
                        className: "col-lg-2 control-label"
                        "Description"
                    DOM.div
                        className: "col-lg-10"
                        DOM.input
                            className: "form-control"
                            placeholder: "Meetup description"
                            id: "description"
                            type: "text"
                            value: @state.meetup.description
                            onChange: @descriptionChanged

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)
