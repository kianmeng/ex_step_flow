defmodule StepFlow.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  get("/", do: send_resp(conn, 200, "Welcome to Step Flow"))

  get "/definitions" do
    StepFlow.WorkflowDefinitionController.index(conn, conn.params)
  end

  get "/definitions/:identifier" do
    StepFlow.WorkflowDefinitionController.show(conn, conn.params)
  end

  post "/launch_workflow" do
    StepFlow.WorkflowController.create_workflow(conn, conn.params)
  end

  post "/workflows" do
    StepFlow.WorkflowController.create(conn, conn.params)
  end

  get "/workflows" do
    StepFlow.WorkflowController.index(conn, conn.params)
  end

  get "/workflows/:id" do
    StepFlow.WorkflowController.show(conn, conn.params)
  end

  put "/workflows/:id" do
    StepFlow.WorkflowController.update(conn, conn.params)
  end

  delete "/workflows/:id" do
    StepFlow.WorkflowController.delete(conn, conn.params)
  end

  post "/workflows/:id/events" do
    StepFlow.WorkflowEventsController.handle(conn, conn.params)
  end

  get "/workflows_statistics" do
    StepFlow.WorkflowController.statistics(conn, conn.path_params)
  end

  post "/worker_definitions" do
    StepFlow.WorkerDefinitionController.create(conn, conn.params)
  end

  get "/worker_definitions" do
    StepFlow.WorkerDefinitionController.index(conn, conn.params)
  end

  get "/worker_definitions/:id" do
    StepFlow.WorkerDefinitionController.show(conn, conn.params)
  end

  get "/jobs" do
    StepFlow.JobController.index(conn, conn.params)
  end

  match(_, do: send_resp(conn, 404, "Not found"))
end
