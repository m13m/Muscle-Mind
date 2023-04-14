defmodule FitnessWeb.WorkoutTemplateLive.Index do
  use FitnessWeb, :live_view

  alias Fitness.WorkoutTemplates
  alias Fitness.WorkoutTemplates.WorkoutTemplate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :workout_templates, list_workout_templates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Workout template")
    |> assign(:workout_template, WorkoutTemplates.get_workout_template!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Workout template")
    |> assign(:workout_template, %WorkoutTemplate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Workout templates")
    |> assign(:workout_template, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    workout_template = WorkoutTemplates.get_workout_template!(id)
    {:ok, _} = WorkoutTemplates.delete_workout_template(workout_template)

    {:noreply, assign(socket, :workout_templates, list_workout_templates())}
  end

  defp list_workout_templates do
    WorkoutTemplates.list_workout_templates()
  end
end