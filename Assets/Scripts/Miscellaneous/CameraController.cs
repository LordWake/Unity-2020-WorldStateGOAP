using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Transform playerPosition;
	public float rotationSpeed;

    void Update()
    {
        FollowPlayer();
    }

	void LateUpdate()
	{
		SmoothRotation();
	}

	private void FollowPlayer()
	{
        transform.position = playerPosition.position;
	}

	private void SmoothRotation()
	{
		transform.forward = Vector3.Lerp(transform.forward, playerPosition.forward, rotationSpeed * Time.deltaTime);
	}
}
