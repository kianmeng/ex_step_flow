defmodule StepFlow.WorkflowView do
  use StepFlow, :view
  alias StepFlow.{ArtifactView, JobView, WorkflowView}

  def render("index.json", %{workflows: %{data: workflows, total: total}}) do
    %{
      data: render_many(workflows, WorkflowView, "workflow.json"),
      total: total
    }
  end

  def render("show.json", %{workflow: workflow}) do
    %{data: render_one(workflow, WorkflowView, "workflow.json")}
  end

  def render("workflow.json", %{workflow: workflow}) do
    result = %{
      id: workflow.id,
      identifier: workflow.identifier,
      version_major: workflow.version_major,
      version_minor: workflow.version_minor,
      version_micro: workflow.version_micro,
      tags: workflow.tags,
      reference: workflow.reference,
      steps: workflow.steps,
      parameters: workflow.parameters,
      created_at: workflow.inserted_at
    }

    result =
      if is_list(workflow.artifacts) do
        artifacts = render_many(workflow.artifacts, ArtifactView, "artifact.json")
        Map.put(result, :artifacts, artifacts)
      else
        result
      end

    if is_list(workflow.jobs) do
      jobs = render_many(workflow.jobs, JobView, "job.json")
      Map.put(result, :jobs, jobs)
    else
      result
    end
  end
end
